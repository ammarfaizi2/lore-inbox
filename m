Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVL0PpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVL0PpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 10:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVL0PpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 10:45:16 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:12205 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751114AbVL0PpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 10:45:14 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: ati X300 support?
Date: Tue, 27 Dec 2005 15:45:31 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net> <200512270149.24440.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512270817340.15649@innerfire.net>
In-Reply-To: <Pine.LNX.4.64.0512270817340.15649@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512271545.31224.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 December 2005 13:17, Gerhard Mack wrote:
> The raedon drm module does not seem to detect the card.

Try finding the place where the supported PCI ids are written, and add your 
card's PCI ID. If the DRM module successfully detects your card, email the 
maintainers with the information (and ideally a patch which adds this 
information).

I don't know for sure, but according to this page:

http://dri.freedesktop.org/wiki/ATIRadeon#head-cef41521e55884edc9cd417b42fb2b8b4fcda672

"X300 denotes a rv370 based card."

This may imply that the r300 driver is useable with this hardware.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
