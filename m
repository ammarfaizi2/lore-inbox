Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270599AbTGNMhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270585AbTGNMhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:37:14 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:30213 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270599AbTGNMVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:21:41 -0400
Date: Mon, 14 Jul 2003 14:27:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: marcelo@conectiva.com.br
Cc: =?unknown-8bit?Q?Frantisek_Rys=E1nek?= <rysanek@fccps.cz>,
       henrique2.gobbi@cyclades.com, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
Message-ID: <20030714142731.A28581@electric-eye.fr.zoreil.com>
References: <20030711212551.A25528@electric-eye.fr.zoreil.com> <002a01c349fc$23a0e8c0$ec00000a@fccps.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <002a01c349fc$23a0e8c0$ec00000a@fccps.cz>; from rysanek@fccps.cz on Mon, Jul 14, 2003 at 01:36:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frantisek Rysánek <rysanek@fccps.cz> :
[...]
> As for the userspace sethdlc.c by Krzystof Halasa: I was using ver.1.12,
> modified by Mr. Romieu, who has "cut some non-compiling functionality."
> The current version from Krzysztof Halasa is 1.15.

To be fair to Krzysztof, the "non-compiling functionality" I cut simply
came from the fact that latest sethdlc utility contained code related to
CONFIG_HDLC_RAW_ETH option which wasn't available in vanilla 2.4.21-pre.
Please note that this specific code exists in 2.4.22-pre3-ac but not in
plain Marcelo's 2.4.22-pre. 

Regards

--
Ueimor
