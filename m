Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTFPMVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTFPMVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:21:08 -0400
Received: from mail.ithnet.com ([217.64.64.8]:27660 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263777AbTFPMVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:21:07 -0400
Date: Mon, 16 Jun 2003 14:34:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: Massive performance drop in routing throughput with
 2.4.21
Message-Id: <20030616143451.26d3de7e.skraw@ithnet.com>
In-Reply-To: <20030616141806.6a92f839.skraw@ithnet.com>
References: <20030616141806.6a92f839.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additional information:

I found another setup which has the same problem reproducable. Since this is no
production unit I can test patches. It may be important to the problem that
there are _three_ network cards, as the test-setup shows no degression in
simple 1-1 through routing but using a third network card ot the same box makes
it woe.

Hope this helps.
Stephan
