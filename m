Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTKIO3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 09:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTKIO3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 09:29:23 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:51411 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262283AbTKIO3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 09:29:23 -0500
X-Sender-Authentication: net64
Date: Sun, 9 Nov 2003 15:29:21 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
Subject: Re: Bug Report: 2.4.23-pre9 / SIS chipset / sundance
Message-Id: <20031109152921.22cdc29f.skraw@ithnet.com>
In-Reply-To: <20031107174824.4853e437.skraw@ithnet.com>
References: <20031107174824.4853e437.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding above topic I can verify that the same hardware setup works if
replacing sundance with tulip ethernet.
So I am pretty confident it has something to do with interrupt sharing (at
least on SIS mb) of sundance driver. Has anybody else experienced troubles there?

Regards,
Stephan
