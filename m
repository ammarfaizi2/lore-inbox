Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUBYSl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUBYSl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:41:28 -0500
Received: from h-68-167-140-98.SNVACAID.covad.net ([68.167.140.98]:30726 "EHLO
	mail.metadata-systems.com") by vger.kernel.org with ESMTP
	id S261614AbUBYSky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:40:54 -0500
Message-ID: <403CEC2E.5030608@metadata-systems.com>
Date: Wed, 25 Feb 2004 10:40:46 -0800
From: Matt Seitz <seitz@metadata-systems.com>
Organization: Metadata Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org> <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The filesystem policy _tends_ to be that dashes and spaces are turned 
> into underscores when used as filenames. Don't ask me why (well, the space 
> part is obvious, since real spaces tend to be a pain to use on the command 
> line, but don't ask me why people tend to conver a dash to an underscore).

Perhaps to comply with the ISO-9660/ECMA-119 standard for CD-ROM file systems? 
ISO 9660/ECMA-119 requires file names to contain only 0-9, uppercase A-Z, 
underscore, a single dot ("."), and a single semicolon (";")[1].  For details, 
see section 7.5.1 of ECMA-119:

http://www.ecma-international.org/publications/standards/Ecma-119.htm

[1] One can use various techniques to create file names that contain additional 
characters within a valid ISO 9660 file system.  However, these file names may 
not be accessible on all operating systems.

