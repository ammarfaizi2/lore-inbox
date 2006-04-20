Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWDTTa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWDTTa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWDTTaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:30:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:32673 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751019AbWDTTay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:30:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BAh0vV2RI6q7zD4oK+fQXW6WfQzuj2Hn2Q11urNXDHG9JLN2cyIGBpEwGcNyHtSfy7Cv79nmobuPxS7f4kPepYHAPE8T9+Dn/YvlKmrRtQEa6FROLEmF5shaj60uGXnlMIRcq9jZWsn1c4Zx64aFfieg+95eyCTMLL66UA50eo0=
Message-ID: <d120d5000604201230y48493995l1bb13d01a8122e11@mail.gmail.com>
Date: Thu, 20 Apr 2006 15:30:53 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Alexey Starikovskiy" <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Cc: "Xavier Bestel" <xavier.bestel@free.fr>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4447B7D6.4030401@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
	 <20060420073713.GA25735@srcf.ucam.org>
	 <4447AA59.8010300@linux.intel.com>
	 <20060420153848.GA29726@srcf.ucam.org>
	 <4447AF4D.7030507@linux.intel.com>
	 <1145549460.23837.156.camel@capoeira>
	 <4447B7D6.4030401@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/06, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com> wrote:
> Xavier Bestel wrote:
> > There are keyboards with power/sleep buttons. It makes sense they have
> > the same behavior than ACPI buttons.
> Agree, make them behave like ACPI buttons -- remove them from input stream, as they do not belong there...

What if there is no ACPI? What if I want to remap the button to do
something else? Input layer is the proper place for them.

--
Dmitry
