Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755903AbWKVQ6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903AbWKVQ6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbWKVQ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:58:07 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:40009 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1755903AbWKVQ6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:58:05 -0500
From: Dmitry Mishin <dim@openvz.org>
Organization: SWsoft
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [patch -mm] net namespace: empty framework
Date: Wed, 22 Nov 2006 19:55:56 +0300
User-Agent: KMail/1.9.4
Cc: Cedric Le Goater <clg@fr.ibm.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org
References: <4563007B.9010202@fr.ibm.com> <4564566F.7030202@fr.ibm.com> <20061122164154.GB17378@sergelap.austin.ibm.com>
In-Reply-To: <20061122164154.GB17378@sergelap.austin.ibm.com>
X-Face: 'h\woBm&GL5>q=4~&$7\8J0Sv3c2a98rBl,dx/@?L4)Tg!C-nz4]2>M>=?utf-8?q?6ZwpyJ=7Ek=7EqqVT-=0A=09=7CIm?=(,W)U}CZo`G#(&OpK?El5u#-mi~%Uo)?X/qE[LE-H88#x'Y<GId$mZ]i%"iG|<=?utf-8?q?Zm/4u=0A=09Ld=2E=23=5B/Am=7D=5DV10UW0qjZUu7?=@;6SQI%Uy^H
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221955.56942.dim@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 19:41, Serge E. Hallyn wrote:
> Quoting Cedric Le Goater (clg@fr.ibm.com):
> > Hello,
> > 
> > Dmitry Mishin wrote:
> > 
> > > This patch looks acceptable for us.
> > 
> > good. shall we merge it then ? see comment below.
> > 
> > > BTW, Daniel, we agreed to be based on the Andrey's patchset. I do not see a
> > > reason, why Cedric force us to make some unnecessary work and move existent
> > > patchset over his interface.
> > 
> > yeah it's a bit different from andrey's but not that much and it's more in
> 
> Where is Andrey's patch?
This thread - http://thread.gmane.org/gmane.linux.network/42666

> 
> > the spirit of uts and ipc namespace (and user namespace if that reaches the
> > kernel one day :) so that's why i made the small changes.
> 
> I agree the namespace frameworks should be consistent, but i don't know
> whether Andrey's is or not.  I'd like to have the framework included so
> we reduce the number of silly rewrites due to clone flag collisions etc.
> 
> > 
> > It also helping the nsproxy/namespace syscalls to have a similar interface
> > to manipulate namespaces. who knows, soon we might be able to have a 'struct
> > namespace' with a ops field to define new namespace types ?
> > 
> > I can also send a empty framework for user namespace  ;)
> 
> Please do - then I'll rebase the patchset I sent to the containes list
> onto your patch, and resubmit the whole userns.
> 
> -serge
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Thanks,
Dmitry.
