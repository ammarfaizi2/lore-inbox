Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318206AbSHIJHd>; Fri, 9 Aug 2002 05:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSHIJHd>; Fri, 9 Aug 2002 05:07:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:15611 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318206AbSHIJHd>; Fri, 9 Aug 2002 05:07:33 -0400
Subject: Re: Patch to enable K6-2 and K6-3 processor optimizations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Bronaugh <dbronaugh@linuxboxen.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020809014840.4e81fbd3.dbronaugh@linuxboxen.org>
References: <20020809014840.4e81fbd3.dbronaugh@linuxboxen.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 11:31:19 +0100
Message-Id: <1028889079.30103.184.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can't actually use MMX/FPU instructions in the kernel in the general
case. That would require saving and restoring the user process floating
point state - which is extremely expensive

