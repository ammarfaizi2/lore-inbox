Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVI3Scn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVI3Scn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVI3Scn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:32:43 -0400
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:64924 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965034AbVI3Scm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:32:42 -0400
Date: Fri, 30 Sep 2005 14:32:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux - fix SCTP socket bug and general IP protocol
 handling
In-Reply-To: <Pine.LNX.4.63.0509301408270.3733@excalibur.intercode>
Message-ID: <Pine.LNX.4.63.0509301431140.3797@excalibur.intercode>
References: <Pine.LNX.4.63.0509301408270.3733@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005, James Morris wrote:

> This patch changes the SELinux IP socket classification logic, so that 
> only an IPPROTO_IP protocol value passed to socket(2) classify the socket 
> as TCP or UDP.

note: in addition to IPPROTO_TCP and IPPROTO_UDP, as expected.


-- 
James Morris
<jmorris@namei.org>
