Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVF0Ovg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVF0Ovg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVF0Oup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:50:45 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:48820
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262022AbVF0NLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:11:32 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: <borislav@users.sourceforge.net>, <hdaps-devel@lists.sourceforge.net>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
       "'Paul Sladen'" <thinkpad@paul.sladen.org>,
       "'Eric Piel'" <Eric.Piel@tremplin-utc.net>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       <linux-kernel@vger.kernel.org>, <linux-thinkpad@linux-thinkpad.org>
Subject: RE: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Date: Mon, 27 Jun 2005 07:10:05 -0600
Message-ID: <003601c57b19$89f0ddb0$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <42BFF220.2060704@grimmer.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A small problem is that the 8042 normally doesn't have any ADCs,
> > however, I assume most of the 8042 implementations in modern
> > notebooks do have at least a few ADCs, for battery monitoring, etc.
>
> Hmm, but isn't that exactly the kind of data that is printed by the
> ibm_acpi kernel module in "/proc/acpi/ibm/ecdump" then?
>
> According to the README "this feature dumps the values of 256 embedded
> controller registers." So shouldn't the reading of the accelerometers
> be included in these values as well?
>
> Or could this mean that the embedded controller might have more than
> these 256 registers that could be read out? Or does it need
> to be "told"
> to poll the accelerometer for these values repeatedly?
>
> Many register values in there change automatically (e.g. fan
> speed), but
> so far we have not seen a pattern of register value changes that look
> like they are related to acceleration of the laptop in any direction.
>
> Bye,
> 	LenZ

Borislav,

	Do you have any input or anything to say? You are probably the one who has
messed more with the ecdump or with the controller and might be able to help
us grow a clue here. Any answer should point us more to were we want.

Could ecdump give any output of the accelerometer?
Could this be really attached to the controller?

.Alejandro

