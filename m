Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUKURhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUKURhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 12:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUKURhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 12:37:24 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:39908 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261655AbUKURhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 12:37:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t2BQH6GFx6ibYUPdiuRnSKoaoec8oWsZ8UivbLlZjtoMjXk5OHWiDt3AwQJltZsxn2PIt63Z/oXMTBk153kGvoHVwcIYRyuyqKYv0Qaf0+KM7CVLXN0Em39T8qdNnBtqi0QXi/MhgEqjRkHU8wpaibHNOAID+Opx1Xd99LaFE64=
Message-ID: <29495f1d04112109372bb8ebe4@mail.gmail.com>
Date: Sun, 21 Nov 2004 09:37:18 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: how netfilter handles fragmented packets
Cc: cranium2003 <cranium2003@yahoo.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.53.0411211714530.18608@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041121153154.85910.qmail@web41403.mail.yahoo.com>
	 <Pine.LNX.4.53.0411211714530.18608@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004 17:15:12 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> >hello,
> >          In ip_output.c file ip_fragmet function when
> >create a new fragmented packet given to output(skb)
> >function. i want to know which function are actually
> >called by output(skb)?
> 
> use stack_dump() (or was it dump_stack()?)

dump_stack(), if you want to dump the current process' stack context.

-Nish
