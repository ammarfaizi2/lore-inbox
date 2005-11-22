Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVKVQ1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVKVQ1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVKVQ1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:27:08 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:19992 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964980AbVKVQ1E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:27:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=bkp0/6k8RdsKHSkzxizZXaPaOk8iDzlmLpDACjpps/5968RmXwKXU0QImlfVZ8aa01zj7TpY+/hNcmf7rHKXz191w8w00G++e/8rLLfdqoYICwluQ7NPq/y86E2u7V44WzZKYneS0lORFdY+gqifUkK4py6iQkms1n7UL6quB9U=
Date: Tue, 22 Nov 2005 17:26:50 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Avi Kivity <avi@argo.co.il>
Cc: jgarzik@pobox.com, jonsmirl@gmail.com, benh@kernel.crashing.org,
       alan@lxorguk.ukuu.org.uk, airlied@gmail.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-Id: <20051122172650.72f454de.diegocg@gmail.com>
In-Reply-To: <43834400.3040506@argo.co.il>
References: <20051121225303.GA19212@kroah.com>
	<20051121230136.GB19212@kroah.com>
	<1132616132.26560.62.camel@gaston>
	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	<1132623268.20233.14.camel@localhost.localdomain>
	<1132626478.26560.104.camel@gaston>
	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
	<43833D61.9050400@argo.co.il>
	<20051122155143.GA30880@havoc.gtf.org>
	<43834400.3040506@argo.co.il>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 22 Nov 2005 18:14:56 +0200,
Avi Kivity <avi@argo.co.il> escribió:

> You exaggerate. Windows drivers work well enough in Windows (or so I 
> presume). One just has to implement the environment these drivers 
> expect, very carefully.

If you're going to use binary drivers it'd be much better to implement
a linux "driver compatibility layer" so at least you don't have to
use crap from other systems

And no, windows drivers don't work well enought in windows
(try enabling the /3GB switch in your box and check how many drivers
break...)
