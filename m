Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWFPObX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWFPObX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWFPObX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:31:23 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:34774 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751416AbWFPObW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:31:22 -0400
Date: Fri, 16 Jun 2006 11:31:15 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       len.brown@intel.com
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Message-ID: <20060616113115.181ecb01@doriath.conectiva>
In-Reply-To: <44909A32.3010304@oracle.com>
References: <44909A32.3010304@oracle.com>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.9.2; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 16:22:26 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

| From: Ben Collins <bcollins@ubuntu.com>
| 
| [UBUNTU:acpi/ec] Use semaphore instead of spinlock to get rid of missed
| interrupts on ACPI EC (embedded controller)

 Why not the new mutex API?

-- 
Luiz Fernando N. Capitulino
