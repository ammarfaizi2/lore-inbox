Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTJSUus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTJSUus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:50:48 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:51630 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262188AbTJSUur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:50:47 -0400
Date: Sun, 19 Oct 2003 17:48:45 -0400
From: John Chia <orange@geek.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8 Migration (CPUfreq, Synaptics, PS/2, undocking, omnibook 6000)
Message-ID: <20031019214845.GA1055@beefchickenpork.org>
References: <20031019160722.GA1172@beefchickenpork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019160722.GA1172@beefchickenpork.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All that remains is the CPUfreq issue -- 

The PS/2 driver uses the passthrough of the synaptics touchpad even if
the synaptics-specialised driver isn't being used.  As the 2.4 driver
did.

Docking/undocking is back after disabling ACPI completely.

John.

On Sun, Oct 19, 2003 at 12:07:22PM -0400, John Chia wrote:
> Summary: 
> Problems undocking in 2.6 kernel; CPUfreq & ps/2 drivers behaving unpleasantly.
