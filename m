Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUAJRjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUAJRjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:39:46 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:19601 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S265279AbUAJRjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:39:32 -0500
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, Feldman@tux.rsn.bth.se,
       Scott <scott.feldman@intel.com>
Subject: Re: 2.4.24 eth0: TX underrun, threshold adjusted.
References: <x665fkb59o@gzp> <1073746559.752.44.camel@tux.rsn.bth.se>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Sat, 10 Jan 2004 18:39:21 +0100
Message-ID: <x6oetb66uu@gzp>
User-Agent: Gnus/5.1004 (Gnus v5.10.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Josefsson <gandalf@wlug.westbo.se>:

| > eth0: TX underrun, threshold adjusted.
| > [10 times]
| > eth0: TX underrun, threshold adjusted.
| 
| > eth0 intel eepro100
| 
| I think you ran the eepro100 driver in 2.4.23 and now in 2.4.24 you are
| using the e100 driver, am I correct?

No, you aren't.

| This isn't really an error, it's an indicator that the pci-bus doesn't
| really keep up, then the NIC has to increase the threshold (it tries to
| start sending the packet out before it's fully transferred from main
| memory to the NIC, it hopes the rest of the packet will have been

Funny because I have changed the mobo/cpu/ram from P3 to P4. Maybe
its related to that change?

| This happens with the eepro100 driver as well but it doesn't tell you
| about it, it just increases the threshold and goes on.

I'm using Becker's eepro100, I'm sure.

| I hope this helps to explain this message.

Thanks.

