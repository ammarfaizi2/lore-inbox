Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSIILao>; Mon, 9 Sep 2002 07:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSIILao>; Mon, 9 Sep 2002 07:30:44 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:41118 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S317102AbSIIL3u>; Mon, 9 Sep 2002 07:29:50 -0400
Date: Mon, 9 Sep 2002 13:34:14 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Claus Rosenberger <Claus.Rosenberger@rocnet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file locking looks strange
Message-ID: <20020909113414.GH16092@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Claus Rosenberger <Claus.Rosenberger@rocnet.de>,
	linux-kernel@vger.kernel.org
References: <44499.213.68.24.98.1031409116.rocnet@deathstar.of.rocnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44499.213.68.24.98.1031409116.rocnet@deathstar.of.rocnet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2002 at 04:31:56PM +0200, Claus Rosenberger wrote:
> How i can informations about file locking for applications.
> 
> if i open a document with one application on the terminalserver and try to
> open the same document  in another session i can write on the second
> session. this happens for example with openoffice. how i can really lock
> the file if one application open this doc for reading and writing ?

read Documentation/locks.txt and Documentation/mandatory.txt.
You can also use advisory locking (man 2 fcntl, lockf), if it's
your own code.

-alex

