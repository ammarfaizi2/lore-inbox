Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVJSBlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVJSBlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVJSBiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:38:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51376 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932438AbVJSBiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:38:46 -0400
Message-ID: <4355A390.9090309@osdl.org>
Date: Tue, 18 Oct 2005 18:38:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       mlindner@syskonnect.de, rroesler@syskonnect.de
Subject: Re: [patch 2.6.14-rc4 0/3] sk98lin: neuter and prepare for removal
References: <10182005213059.12304@bilbo.tuxdriver.com>
In-Reply-To: <10182005213059.12304@bilbo.tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:

>These patches take steps towards removing sk98lin from the upstream
>kernel.
>
>	-- Remove sk98lin's MODULE_DEVICE_TABLE to avoid
>	confusing userland tools about which driver to load;
>
>	-- Mark sk98lin as Obsolete in the MAINTAINERS file; and,
>
>	-- Add sk98lin to the feature-removal-schedule.txt file in the
>	Documentation directory.
>
>I accept the possibility that I may be jumping the gun on this.
>However, I think it is worth opening this discussion.
>
>Patches to follow...
>  
>
I applaud the initiative, but this it is too premature to obsolete the 
existing driver. There may be lots of chip versions and other variables 
that make
the existing driver a better choice.  Maybe eepro100 is a better target
for removal right now.

