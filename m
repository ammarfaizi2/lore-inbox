Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWD1JX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWD1JX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWD1JX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:23:56 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:47884 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030336AbWD1JXx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:23:53 -0400
Message-ID: <4451DF24.20408@argo.co.il>
Date: Fri, 28 Apr 2006 12:23:48 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org,
       David Schwartz <davids@webmaster.com>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <20060426201909.GN27946@ftp.linux.org.uk> <20060426213700.GB22894@mars.ravnborg.org>
In-Reply-To: <20060426213700.GB22894@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 09:23:51.0539 (UTC) FILETIME=[76692C30:01C66AA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> The original question was related to port existing C++ code to be used
> as a kernel module.
> Magically this always ends up in long discussions about how applicable
> C++ is the the kernel as such which was not the original intent.
>
> So following the original intent it does not matter what subset is
> sanely used, only what adaptions is needed to kernel proper to support
> modules written in C++.
>
>   

Here at last is a sane response. If the kernel were enhanced/bastardized 
(pick one) to support C++ modules, we could evaluate how C++ actually 
does in terms of runtime and developer performance.

> But I have seen no patches this time either, so required modifications
> are yet to be identified.
>   

Since such patches are sure to be rejected (apparently renaming 'struct 
class' would wreak havoc on the development process), I doubt that they 
will appear. Not to mention the attacks on the submitters that would follow.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

