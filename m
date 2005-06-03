Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFCKG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFCKG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 06:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFCKG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 06:06:59 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:46250 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261202AbVFCKG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 06:06:58 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: question why need open /dev/console in init() when starting kernel
To: Tomko <tomko@avantwave.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 03 Jun 2005 12:06:53 +0200
References: <4betH-75D-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1De94o-0001Dv-2f@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomko <tomko@avantwave.com> wrote:

> Do anyone know why it need to open("/dev/console"....) at the end of the
> init() before calling execve("/sbin/init") ? Why open this for the in ,
> out , err channel at this moment but not open it at the time when going
> to use , e.g. open it in the shell .

How is the shell supposed to know which files to open, or if it's supposed
to open files at all?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
