Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318078AbSHDPkq>; Sun, 4 Aug 2002 11:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSHDPkq>; Sun, 4 Aug 2002 11:40:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18424 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318078AbSHDPko>; Sun, 4 Aug 2002 11:40:44 -0400
Subject: Re: 2.4.19 IDE Partition Check issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alien.ant@ntlworld.com
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D4D4544.4045B5D3@ntlworld.com>
References: <20020804054239.62923.qmail@web9203.mail.yahoo.com>
	<1028470037.14195.24.camel@irongate.swansea.linux.org.uk> 
	<3D4D4544.4045B5D3@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 18:02:33 +0100
Message-Id: <1028480553.14195.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 16:16, alien.ant@ntlworld.com wrote:
> 
> Alan - I'm wondering if this issue is related to Maxtor drives? All the
> reports I have seen of this problem have featured drives from this
> manufacturer.

The ALi hang may well be sort of this. If its what Andre thinks then its
lack of support for LBA48 on ALi interface hardware (or at least for the
documentation we currently have on how to program it). If so -ac2 should
sort that one out


