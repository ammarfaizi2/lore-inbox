Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbRBNWNA>; Wed, 14 Feb 2001 17:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbRBNWMv>; Wed, 14 Feb 2001 17:12:51 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:62471 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130455AbRBNWMi>; Wed, 14 Feb 2001 17:12:38 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: ECN for servers ?
In-Reply-To: <20010214190128.G923@ppetru.net>
	<96eqhm$33k$1@cesium.transmeta.com>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 14 Feb 2001 22:11:57 +0000
In-Reply-To: <96eqhm$33k$1@cesium.transmeta.com> ("H. Peter Anvin"'s message of "14 Feb 2001 12:41:26 -0800")
Message-ID: <m2ofw4nccy.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Con: people behind broken firewalls can't connect.

Are you sure that is correct?  "Servers" normally listen for incoming
connections from clients rather than establish them[1]. So, if the
server implements ECN then it will respond appropriately to incoming
SYN packets irrespective of whether the ECN bits are set. People, who
use ECN, who are behind a broken firewall will have problems
connecting irrespective of whether or not the server implements ECN.


[1] Passive FTP being an exception.
