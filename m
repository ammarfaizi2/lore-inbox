Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbTCZWqh>; Wed, 26 Mar 2003 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbTCZWqg>; Wed, 26 Mar 2003 17:46:36 -0500
Received: from gate.in-addr.de ([212.8.193.158]:24028 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id <S262583AbTCZWqf>;
	Wed, 26 Mar 2003 17:46:35 -0500
Date: Wed, 26 Mar 2003 23:56:17 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Lincoln Dale <ltd@cisco.com>, Matt Mackall <mpm@selenic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
Message-ID: <20030326225617.GB13344@marowsky-bree.de>
References: <5.1.0.14.2.20030327091616.03a2ce60@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.0.14.2.20030327091616.03a2ce60@mira-sjcm-3.cisco.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-27T09:16:18,
   Lincoln Dale <ltd@cisco.com> said:

> what logic do you use to identify "identical devices"?
> same data reported from SCSI Report_LUNs?  or perhaps the same data 
> reported from a SCSI_Inquiry?

That would work well.

We do parse device specific information in order to auto-configure the md
multipath at setup time. After that, magic is on disk...

> does one now need to add logic into the kernel to provide some multipathing
> for HDS disks?

Topology discovery is user-space! It does not need to live in the kernel.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
