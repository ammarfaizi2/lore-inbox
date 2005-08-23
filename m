Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVHWTXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVHWTXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVHWTXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:23:05 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:4465 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S932317AbVHWTXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:23:04 -0400
Message-ID: <430B07B5.2070907@davyandbeth.com>
Date: Tue, 23 Aug 2005 06:25:41 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bert hubert <bert.hubert@netherlabs.nl>
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com>
In-Reply-To: <430B01FB.2070903@davyandbeth.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2005 19:22:40.0812 (UTC) FILETIME=[077B26C0:01C5A818]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davy Durham wrote:

>
> I'm currently re-writing some code to make it use select() instead of 
> epoll_wait() and see if everything is suddently fixed.  If so, then I 
> will suspect that epoll has a problem.  But it's still not ruled out 
> being my fault since it could be a timing issue that makes the crash 
> show up.
>
Well, the select() replacement works fine... so hrmm..


