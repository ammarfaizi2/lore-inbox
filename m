Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVIDO1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVIDO1R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVIDO1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 10:27:17 -0400
Received: from cavan.codon.org.uk ([217.147.81.22]:49632 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S1750796AbVIDO1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 10:27:17 -0400
Date: Sun, 4 Sep 2005 15:26:00 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: Brand-new notebook useless with Linux...
Message-ID: <20050904142600.GA25512@srcf.ucam.org>
References: <200509031859_MC3-1-A720-F705@compuserve.com> <E1EBje3-0002GW-00@chiark.greenend.org.uk> <20050904091012.GA4394@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050904091012.GA4394@fargo>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 11:10:12AM +0200, David Gómez wrote:

> Smart batteries are accesed thru the SMBus. If you want to know
> battery information, like the charge, you need to talk to the SMBus.

Smart batteries are i2c devices, but you talk to them via the embedded 
controller rather than via the system SMBus.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
