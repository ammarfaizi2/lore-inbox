Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266004AbSKFIvT>; Wed, 6 Nov 2002 03:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbSKFIvT>; Wed, 6 Nov 2002 03:51:19 -0500
Received: from redrock.inria.fr ([138.96.248.51]:64477 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S266004AbSKFIvT>;
	Wed, 6 Nov 2002 03:51:19 -0500
SCF: #mh/Mailbox/outboxDate: Wed, 6 Nov 2002 09:47:08 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
To: linux-kernel@vger.kernel.org, dwmw2@redhat.com, andrew.grover@intel.com,
       ptb@it.uc3m.es, ptb@it.uc3m.es, jw@pegasys.ws
Subject: Re: ACPI does not switch off the laptop
Message-Id: <20021106094708.1052afb0.Manuel.Serrano@sophia.inria.fr>
References: <20021105095145.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 06 Nov 2002 09:51:59 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

in a yesterday mail titled "ACPI does not switch off the laptop" I
have reported that I was not able to switch the computer off using any
of "halt" and "poweroff" command. I now would like to apologize. It
turns out that I was not loading ospm_system and ospm_processor
modules. When I *do load* them, then "halt" switches the computer off
as expected. According to the ACPI kernel document this is an expected
feature. Thus, I was wrong and I have to apologize.

Anyway, many thanks to you all your useful answers and help.

-- 
Manuel
