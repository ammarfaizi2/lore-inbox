Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265404AbTFMRNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbTFMRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:13:52 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265404AbTFMRNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:13:48 -0400
Date: Fri, 13 Jun 2003 18:34:29 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306131734.h5DHYTtn000213@81-2-122-30.bradfords.org.uk>
To: jsimmons@infradead.org, terje_fb@yahoo.no
Subject: Re: Real multi-user linux
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     The next stage will be non PC boards supporting more than
> one graphics display output. Every now and then you see such a
> board. I seen a 8 graphics chip board with 8 video outputs.

As the number of terminals increases you might want to investigate the
possibility of terminal driving units connected to the main box, like
this:

-----   -----   -----   -----   -----   -----
| T |   | T |   | T |   | T |   | T |   | T |   
-----   -----   -----   -----   -----   -----
  |______ | ______|       |______ | ______|
        | | |                   | | |
        -----                   -----
        | D |                   | D |
        -----                   -----
          |_______________________|
                      |
                    -----
                    | L |
                    -----

T=Terminal
D=Terminal driving unit
L=Linux box

John.
