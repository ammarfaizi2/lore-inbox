Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966274AbWKNTTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966274AbWKNTTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966272AbWKNTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:19:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:53704 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965940AbWKNTTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:19:30 -0500
Message-ID: <455A16B5.7040009@pobox.com>
Date: Tue, 14 Nov 2006 14:19:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, mjg59@srcf.ucam.org
Subject: Re: [patch] libata: change order of _SDD/_GTF execution (resend #3)
References: <20060928182211.076258000@localhost.localdomain>	<20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>	<20060929021353.GB22082@srcf.ucam.org> <20061110161447.b4599cbd.kristen.c.accardi@intel.com>
In-Reply-To: <20061110161447.b4599cbd.kristen.c.accardi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> Make the sdd call come before gtf.  _SDD is used to provide
> input to the _GTF file, so it should be executed first.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

applied


