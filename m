Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTJ0Eb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 23:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTJ0Eb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 23:31:57 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:63433 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263426AbTJ0Eb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 23:31:56 -0500
Date: Mon, 27 Oct 2003 05:31:53 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: John Levon <levon@movementarian.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>, davem@redhat.com,
       matthias.andree@gmx.de
Subject: Re: CONFIG_IP_NF_IPTABLES=m breaks 2.6 BK compile
Message-ID: <20031027043153.GA16095@merlin.emma.line.org>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	davem@redhat.com
References: <20031027034214.GA26161@merlin.emma.line.org> <20031027041039.GA42608@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027041039.GA42608@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, John Levon wrote:

> Please try the below. The option needs to inherit whatever iptables
> itself got set to.
...
> -	depends on IP_NF_IPTABLES!=n && BRIDGE_NETFILTER
> +	depends on IP_NF_IPTABLES && BRIDGE_NETFILTER

Compiles fine (haven't run it yet). Thank you!

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
