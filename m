Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSHGPzB>; Wed, 7 Aug 2002 11:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSHGPzB>; Wed, 7 Aug 2002 11:55:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49914 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318626AbSHGPzA>; Wed, 7 Aug 2002 11:55:00 -0400
Subject: Re: UNIX domain socket hanging around when not closed
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Hudec <bulb@vagabond.cybernet.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020807153251.GD27745@vagabond>
References: <20020807153251.GD27745@vagabond>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 18:18:10 +0100
Message-Id: <1028740690.18130.310.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 16:32, Jan Hudec wrote:
> What I do is create a unix socket in /tmp and wait for clients to
> connect in. The program removes the socket dentry when it shuts down,
> but it sometimes crashes and the socket remains there.
> 
> Is there some reason the socket should remain unless explicitely
> removed?

Thats what is supposed to happen. If its dead then in your server you
can remove it and create a new one. 

