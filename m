Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWI1Swd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWI1Swd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWI1Swd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:52:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:51994 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751416AbWI1Swa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:52:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ij4yRUya0VW5p6NVw2yKrY3ls5/JfAJup2rERMsz5uv9vSDhu7Ocqq3ljixXo9NtuI8K/XPPpjJziAvNQJqxfDzK4mL/25jy9BDqRLfgimeIWJCq92szQll3eFurSFQAlwCQVmmDjRK/5X/TMMdHuFABihW7MoBGnDxGMZRNLdQ=
Date: Thu, 28 Sep 2006 20:51:44 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.intel.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 1/2] libata: _GTF support
Message-Id: <20060928205144.98aefd13.diegocg@gmail.com>
In-Reply-To: <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
References: <20060928182211.076258000@localhost.localdomain>
	<20060928112901.62ee8eba.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 28 Sep 2006 11:29:01 -0700,
Kristen Carlson Accardi <kristen.c.accardi@intel.com> escribió:

> +config SATA_ACPI
> +	bool
> +	depends on ACPI && PCI

Why not s/SATA_ACPI/ACPI/ and delete the kconfig option, so this
feature gets enabled automatically when user enables ACPI?
