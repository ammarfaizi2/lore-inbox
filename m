Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTHTQZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbTHTQZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:25:34 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:64222 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261486AbTHTQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:25:33 -0400
Date: Wed, 20 Aug 2003 18:25:30 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Casey Carter <ccarter@cs.uiuc.edu>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [2.4.2X] "Undeletable" ARP entries?
Message-ID: <20030820162530.GF12023@merlin.emma.line.org>
Mail-Followup-To: Casey Carter <ccarter@cs.uiuc.edu>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
References: <20030820113208.GA11163@merlin.emma.line.org> <3F438C32.3070705@cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F438C32.3070705@cs.uiuc.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003, Casey Carter wrote:

> Try "arp -i eth1 -d 192.168.4.4 pub"

Appears to work (tried on both kernel versions), thank you.

The question why this doesn't show up in "ip neigh" remains though.
