Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132529AbRDHKWo>; Sun, 8 Apr 2001 06:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132531AbRDHKWe>; Sun, 8 Apr 2001 06:22:34 -0400
Received: from mail.zmailer.org ([194.252.70.162]:12040 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132529AbRDHKW1>;
	Sun, 8 Apr 2001 06:22:27 -0400
Date: Sun, 8 Apr 2001 13:22:05 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: kumon@flab.fujitsu.co.jp
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Michael Peddemors <michael@linuxmagic.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: goodbye
Message-ID: <20010408132205.O805@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0104031800030.14090-100000@imladris.rielhome.conectiva> <20010404012102Z131724-406+7418@vger.kernel.org> <20010408023228.L805@mea-ext.zmailer.org> <200104080510.OAA23675@asami.proc.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104080510.OAA23675@asami.proc.flab.fujitsu.co.jp>; from kumon@flab.fujitsu.co.jp on Sun, Apr 08, 2001 at 02:10:52PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2001 at 02:10:52PM +0900, kumon@flab.fujitsu.co.jp wrote:
> How about creating an additional ML,
> the new ML (say LKML-DUL) is used to send mails from DUL to LKML, but
> such mails are not sent to LMKL.

	Layering and technology problem.

	SMTP receiver does those RBL/DUL/ORBS analysis, and its policy
	control does not know where exactly the email is heading into
	(that is, the reception policy is system level, not by recipients.)

	List-processing is done separately from input at Majordomo.
	Long after the reception processing.
....
> --
> Computer Systems Laboratory, Fujitsu Labs.
> kumon@flab.fujitsu.co.jp

/Matti Aarnio
