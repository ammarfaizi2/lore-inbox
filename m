Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVCDJ01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVCDJ01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVCDJ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:26:26 -0500
Received: from upco.es ([130.206.70.227]:30671 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262703AbVCDJXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:23:38 -0500
Date: Fri, 4 Mar 2005 10:23:33 +0100
From: Romano Giannetti <romanol@upco.es>
To: Andrew Morton <akpm@osdl.org>
Cc: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Message-ID: <20050304092333.GA11862@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Andrew Morton <akpm@osdl.org>,
	Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dtor_core@ameritech.net>
References: <422618F0.3020508@telefonica.net> <20050302134342.4c9cc488.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050302134342.4c9cc488.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 01:43:42PM -0800, Andrew Morton wrote:
> 
> That's an ACPI problem, I assume?
> 

Probably. There is something flaky in ACPI event (it happened sometime
between 2.6.7 and 2.6.9, i tried to check all the patches, but I had find
nothing. 

Could someone please check http://bugme.osdl.org/show_bug.cgi?id=4124 and
tell me what to do to help in debugging it? 

What is very strange is why "power button" and "read battery current capacity" 
events are working ok, and "sleep button" or "CRT switch button" or "ac
plugged/unplugged" seems more or less random delayed. 

Romano 



-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
