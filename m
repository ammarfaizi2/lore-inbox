Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWBAP4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWBAP4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWBAP4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:56:16 -0500
Received: from ns.firmix.at ([62.141.48.66]:41097 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1161101AbWBAP4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:56:15 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Oliver Neukum <oliver@neukum.org>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, acahalan@gmail.com
In-Reply-To: <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
	 <200601311333.36000.oliver@neukum.org>
	 <200601311444.47199.vda@ilport.com.ua>
	 <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 01 Feb 2006 16:55:03 +0100
Message-Id: <1138809303.16643.28.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 16:37 +0100, Jan Engelhardt wrote:
[...]
> >Do we need to expose IDE master/slave, primary/secondary concepts in Linux?
> >
> AFAICS, we do. hda is always primary slave, etc. With the SCSI layer it's
> (surprisingly) the other way round, sda just happens to be the first disk
> inserted (SCA, USB, etc.)

The (historical) reason was: There were not enough major/minor numbers
(IIRC 8 bit for each of them) for a sane (and static) SCSI device number
mapping (similar to IDE) - just multiply the possible # of partitions *
# of LUNs * # IDs for a few controllers.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

