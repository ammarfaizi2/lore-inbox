Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVCPQOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVCPQOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVCPQOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:14:15 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:40848 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262672AbVCPQOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:14:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GH8+p5kB3kDEKghOwTn3r9UywGMjepK4dXTuDlcqNV3OKnFo6kMXgaLfw8nuV5NcB9pydcI7S8Z6CkeRtAbkrXVAcDDXbBj7qnRbM4LX06CSXJ9Olh3Og2Fv9fJLbAJl8QxnNctt4/je+rgKbYSnAI5+6eIi/XilMQP/a7K51ts=
Message-ID: <9e473391050316081467679b5@mail.gmail.com>
Date: Wed, 16 Mar 2005 11:14:09 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: Another drm/dri lockup - when moving the mouse
Cc: Roland Scheidegger <rscheidegger_lists@hispeed.ch>,
       Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <42383A27.9060101@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <423802E6.1020308@aitel.hist.no> <423822FA.6020501@hispeed.ch>
	 <42383A27.9060101@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 14:52:39 +0100, Helge Hafting
<helge.hafting@aitel.hist.no> wrote:
> No usb.  The mouse is connected to the ps/2 mouse port.  As I mentioned,
> this is
> not a recent problem.  I could never load dri on this machine without
> such a crash.  I can check whether the IRQ gets shared though.

Can you replace the PS/2 mouse with a USB one? This sounds to me like
a hardware problem or the driver for your PS/2 mouse is interfering
with DRM.

-- 
Jon Smirl
jonsmirl@gmail.com
