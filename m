Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271413AbTGXJQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271416AbTGXJOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:14:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:31384 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271413AbTGXJOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:14:05 -0400
Date: Thu, 24 Jul 2003 11:28:50 +0200
From: Dominik Brugger <ml.dominik83@gmx.net>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1] ACPI slowdown
Message-Id: <20030724112850.0e311b7a.ml.dominik83@gmx.net>
In-Reply-To: <87el0gv3g9.fsf@deneb.enyo.de>
References: <878yqpptez.fsf@deneb.enyo.de>
	<20030723114421.34eb7149.dominik83@gmx.net>
	<87el0gv3g9.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003 08:33:42 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> Could you post the output of "tail /proc/acpi/thermal_zone/THRM/*"?
> Thanks.

$ tail /proc/acpi/thermal_zone/THRM/*
==> /proc/acpi/thermal_zone/THRM/cooling_mode <==
cooling mode:            active

==> /proc/acpi/thermal_zone/THRM/polling_frequency <==
<polling disabled>

==> /proc/acpi/thermal_zone/THRM/state <==
state:                   ok

==> /proc/acpi/thermal_zone/THRM/temperature <==
temperature:             37 C

==> /proc/acpi/thermal_zone/THRM/trip_points <==
critical (S5):           70 C
passive:                 70 C: tc1=4 tc2=3 tsp=60 devices=0xdff6cde8
active[0]:               70 C: devices=0xdff64d68

-- 
-Dominik Brugger
