Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271741AbTGRJsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271583AbTGRJsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:48:24 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:49589 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S271602AbTGRJgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:36:20 -0400
Date: Fri, 18 Jul 2003 11:51:08 +0200
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: Re: 2.6.0-test1 gets corrupted data when loading init
Message-ID: <20030718095108.GE5964@h55p111.delphi.afb.lu.se>
References: <20030718083458.GC5964@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718083458.GC5964@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19dRtM-00035A-00*rQTi44LqsSg*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 10:34:58AM +0200, Anders Gustafsson wrote:
> It breaks between 2.5.70 and 2.5.70-bk1, which contains a update in the
> aic79xx-drivers, so my guess is related to that.

http://linux.bkbits.net:8080/linux-2.5/cset@1.1127.6.4 is the changeset that
makes it stop working.

(and if that cset-number isn't stable the comments for it are:

Aic79xx Driver Update
 o Change handling of the Rev. A packetized lun output bug
   to be more efficient by having the sequencer copy the
   single byte of valid lun data into the long lun field.

)

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
