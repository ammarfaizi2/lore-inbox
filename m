Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRFWPuD>; Sat, 23 Jun 2001 11:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264176AbRFWPty>; Sat, 23 Jun 2001 11:49:54 -0400
Received: from pat.uio.no ([129.240.130.16]:32955 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264169AbRFWPtn>;
	Sat, 23 Jun 2001 11:49:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: RPC vs Socket
In-Reply-To: <20010621052321.24581.qmail@nw171.netaddress.usa.net>
	<20010623160658.A19533@artax.karlin.mff.cuni.cz>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Jun 2001 17:49:39 +0200
In-Reply-To: Jan Hudec's message of "Sat, 23 Jun 2001 16:06:58 +0200"
Message-ID: <shs66dnryb0.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jan Hudec <bulb@ucw.cz> writes:

     > Both seem to have pros and cons. RPC should be easier to write
     > (especialy the server side), but it performs bad with UDP on
     > slow links. (NFS did not work on 115200 serial line because of
     > too many dropped packets - TCP flow control too badly needed in
     > such cases). Or can linux do RPC over TCP?

The RPC client code for TCP is ready and already working both in
2.2.18+ and 2.4.x.

The server code however needs work.

Cheers,
  Trond
