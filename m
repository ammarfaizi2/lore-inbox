Return-Path: <linux-kernel-owner+w=401wt.eu-S1754608AbXAAXF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbXAAXF4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbXAAXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:05:56 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:33300 "EHLO
	mail.clusterfs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbXAAXFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:05:55 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17817.37844.730977.13636@gargle.gargle.HOWL>
Date: Tue, 2 Jan 2007 02:05:56 +0300
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <Pine.LNX.4.64.0701012356410.5162@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	<E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	<20061221185850.GA16807@delft.aura.cs.cmu.edu>
	<Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	<1166869106.3281.587.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	<4593890C.8030207@panasas.com>
	<1167300352.3281.4183.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
	<1167388475.6106.51.camel@lade.trondhjem.org>
	<Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
	<17816.29254.497543.329777@gargle.gargle.HOWL>
	<Pine.LNX.4.64.0701012356410.5162@artax.karlin.mff.cuni.cz>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000330 b729264a8a9d5b9a826c32c43a66f4da
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka writes:

[...]

 > 
 > BTW. How does ReiserFS find that a given inode number (or object ID in 
 > ReiserFS terminology) is free before assigning it to new file/directory?

reiserfs v3 has an extent map of free object identifiers in
super-block. reiser4 used 64 bit object identifiers without reuse.

 > 
 > Mikulas

Nikita.

