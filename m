Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTAVMKL>; Wed, 22 Jan 2003 07:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAVMKL>; Wed, 22 Jan 2003 07:10:11 -0500
Received: from k100-145.bas1.dbn.dublin.eircom.net ([159.134.100.145]:9481
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S267446AbTAVMKK>; Wed, 22 Jan 2003 07:10:10 -0500
Message-ID: <3E2E8B76.5000805@Linux.ie>
Date: Wed, 22 Jan 2003 12:15:50 +0000
From: Padraig@Linux.ie
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ok, which wise guy did this?
References: <20030122064047.D41405@shell.cyberus.ca>
In-Reply-To: <20030122064047.D41405@shell.cyberus.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> I just booted my spanking new P4 HT PC last night using 2.5.58
> and to my dissapointment the enumeration of the ethx devices is
> reversed. I have 5 ethernet ports on this; eth0-4 on 2.4.x are now listed
> as eth4-0. This is rude.

If you depend on the order then you must explicitly name the devices
like you want. I've done something like this in the past.

ip link set dev eth0 name interface-1
ip link set dev eth1 name interface-2

I guess you could use a temp name and keep the eth[0-4]
naming if you prefer.

Pádraig.

