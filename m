Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUANJfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUANJfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:35:12 -0500
Received: from poup.poupinou.org ([195.101.94.96]:55092 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S264428AbUANJeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:34:10 -0500
Date: Wed, 14 Jan 2004 10:33:35 +0100
To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com, pavel@ucw.cz,
       cpufreq@www.linux.org.uk, linux@brodo.de, linux-kernel@vger.kernel.org
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114093335.GO14031@poupinou.org>
References: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com> <20040113230605.GM14674@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113230605.GM14674@redhat.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:06:05PM +0000, Dave Jones wrote:
> For minimal parsing of the ACPI P state tables, we shouldn't need the
> full-blown interpretor IMO.

Unfortunately, no.
Some laptop use a _INI method in order to 'write' to the _PST node..
In such laptop, the only parsing option will give you only crasp 
(see some post related to this issue on the ACPI dev list).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
