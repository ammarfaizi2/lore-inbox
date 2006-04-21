Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWDUI0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWDUI0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWDUI0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:26:48 -0400
Received: from iona.labri.fr ([147.210.8.143]:65205 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932275AbWDUI0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:26:47 -0400
Message-ID: <44489675.1080107@labri.fr>
Date: Fri, 21 Apr 2006 10:23:17 +0200
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [libata] atapi_enabled problem
References: <44477D93.50501@labri.fr>	<20060420082852.f679a376.rdunlap@xenotime.net>	<4447AD52.60402@labri.fr> <20060420093112.1ebbac16.rdunlap@xenotime.net>
In-Reply-To: <20060420093112.1ebbac16.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> 
> Hopefully it's behind us then...

Not really in fact... Even with the atapi_enabled=1 set in the code, I
get the errors when either "AHCI SATA support" or "Intel PIIX/ICH SATA
support" are compiled as built-in.

Putting them as modules (both) solve the problem (don't ask me why!).

Regards
-- 
Emmanuel Fleury              | Office: 211
Associate Professor,         | Phone: +33 (0)5 40 00 35 24
LaBRI, Domaine Universitaire | Fax:   +33 (0)5 40 00 66 69
351, Cours de la Libération  | email: emmanuel.fleury@labri.fr
33405 Talence Cedex, France  | URL: http://www.labri.fr/~fleury
