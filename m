Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWDTQdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWDTQdg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWDTQdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:33:36 -0400
Received: from fmr18.intel.com ([134.134.136.17]:3817 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751043AbWDTQdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:33:35 -0400
Message-ID: <4447B7D6.4030401@linux.intel.com>
Date: Thu, 20 Apr 2006 20:33:26 +0400
From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>	 <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com>	 <20060420153848.GA29726@srcf.ucam.org>  <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira>
In-Reply-To: <1145549460.23837.156.camel@capoeira>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> There are keyboards with power/sleep buttons. It makes sense they have
> the same behavior than ACPI buttons.
Agree, make them behave like ACPI buttons -- remove them from input stream, as they do not belong there...
