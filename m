Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271262AbTG2FbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271264AbTG2FbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:31:15 -0400
Received: from [62.29.64.94] ([62.29.64.94]:51328 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S271262AbTG2FbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:31:14 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm1
Date: Tue, 29 Jul 2003 08:33:02 +0300
User-Agent: KMail/1.5.9
References: <20030727233716.56fb68d2.akpm@osdl.org>
In-Reply-To: <20030727233716.56fb68d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-1=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200307290833.02848.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some things I noticed:

1- Seems like you missed out framebuffer patch ( there was a little s/</<= 
patch ) so we don't see any penguin at startup anymore.

2- Con's patch makes KDE's sound daemon skip ( aRts ) when using Juk ( KDE 
JukeBox ) [ to skip just minimize/maximize any window fast ] . Seems like 
problem is at aRts decoding as mplayer -ao arts works fine without skips.

Regards,
/ismail
