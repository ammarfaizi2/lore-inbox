Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263754AbUDVAvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbUDVAvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 20:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUDVAvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 20:51:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263763AbUDVAvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 20:51:32 -0400
Date: Wed, 21 Apr 2004 20:45:42 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@redhat.com>
cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       <cfriesen@nortelnetworks.com>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <20040421132047.026ab7f2.davem@redhat.com>
Message-ID: <Xine.LNX.4.44.0404212042540.20483-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, David S. Miller wrote:

> On Wed, 21 Apr 2004 19:03:40 +0200
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> > Heise.de made it appear, as if the only news was that with tcp
> > windows, the propability of guessing the right sequence number is not
> > 1:2^32 but something smaller.  They said that 64k packets would be
> > enough, so guess what the window will be.
> 
> Yes, that is their major discovery.  You need to guess the ports
> and source/destination addresses as well, which is why I don't
> consider this such a serious issue personally.
>
> It is mitigated if timestamps are enabled, because that becomes
> another number you have to guess.
> 
> It is mitigated also by randomized ephemeral port selection, which
> OpenBSD implements and we could easily implement as well.

What about the techniques mentioned in
http://www.ietf.org/internet-drafts/draft-ietf-tcpm-tcpsecure-00.txt ?

Curiously there is no mention of port guessing or timestamps there.


- James
-- 
James Morris
<jmorris@redhat.com>


