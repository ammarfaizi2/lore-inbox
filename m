Return-Path: <linux-kernel-owner+w=401wt.eu-S932875AbWL1KGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbWL1KGA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932893AbWL1KF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:05:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42049 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbWL1KF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:05:58 -0500
Subject: Re: Finding hardlinks
From: Arjan van de Ven <arjan@infradead.org>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-Reply-To: <4593890C.8030207@panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 28 Dec 2006 11:05:52 +0100
Message-Id: <1167300352.3281.4183.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It seems like the posix idea of unique <st_dev, st_ino> doesn't
> hold water for modern file systems 

are you really sure?
and if so, why don't we fix *THAT* instead, rather than adding racy
syscalls and such that just can't really be used right...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

