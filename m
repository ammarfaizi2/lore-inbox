Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290419AbSAXWpD>; Thu, 24 Jan 2002 17:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290428AbSAXWox>; Thu, 24 Jan 2002 17:44:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5386 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290419AbSAXWol>; Thu, 24 Jan 2002 17:44:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFC: booleans and the kernel
Date: 24 Jan 2002 14:44:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2q2oj$jk$1@cesium.transmeta.com>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com> <20020124223325.GA886@tapu.f00f.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020124223325.GA886@tapu.f00f.org>
By author:    Chris Wedgwood <cw@f00f.org>
In newsgroup: linux.dev.kernel
> 
> It seems everyone is discussing code efficiency and such like.... How
> about we just assume that whether we use if(bool) or if(int) the
> compiler produces euqally good and bad code --- I see no evidence to
> suggest otherwise.
> 

Try inserting a compilation unit or other hard optimization boundary.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
