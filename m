Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSKTVnf>; Wed, 20 Nov 2002 16:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSKTVnf>; Wed, 20 Nov 2002 16:43:35 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:57590 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262712AbSKTVne>; Wed, 20 Nov 2002 16:43:34 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A52A@orsmsx119.jf.intel.com> 
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A52A@orsmsx119.jf.intel.com> 
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Ducrot Bruno'" <poup@poupinou.org>, Felix Seeger <seeger@sitewaerts.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Nov 2002 21:47:22 +0000
Message-ID: <25526.1037828842@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrew.grover@intel.com said:
>  It would be great if someone could take a look at the sonypi driver
> and see what can be done to integrate it better with ACPI. ACPI
> includes an EC driver, so at the minimum, sonypi should use that
> instead of poking the EC itself, perhaps. 

Surely a proper driver should always be preferred over binary-only bytecode?

The sonypi driver looks like it properly requests the regions it uses; they
should be marked busy. Why is the ACPI code touching them?

--
dwmw2


