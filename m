Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTJNIph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJNIph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:45:37 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7656 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262251AbTJNIpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:45:36 -0400
Message-ID: <3F8BB7AE.2040507@namesys.com>
Date: Tue, 14 Oct 2003 12:45:34 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Wes Janzen <superchkn@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens
 to them?
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk> <20031014074020.GC13117@bitwizard.nl> <200310140811.h9E8Bxq1000831@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200310140811.h9E8Bxq1000831@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps we should tell people to first write to the bad block, and only 
if the block remains bad after triggering the remapping by writing to it 
should you make any effort to get the filesystem to remap it for you.  
What do you think?

Rogier has not indicated that he has tried writing to the bad sector, 
has he?

-- 
Hans


