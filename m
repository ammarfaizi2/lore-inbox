Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTAKBs6>; Fri, 10 Jan 2003 20:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbTAKBs6>; Fri, 10 Jan 2003 20:48:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50835
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266615AbTAKBs6>; Fri, 10 Jan 2003 20:48:58 -0500
Subject: Re: How much we can trust packet timestamping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: uaca@alumni.uv.es,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dveitch@unimelb.edu.au
In-Reply-To: <20030110190706.A6866@almesberger.net>
References: <20021230112838.GA928@pusa.informat.uv.es>
	 <1041253743.13097.3.camel@irongate.swansea.linux.org.uk>
	 <20030110190706.A6866@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042253032.32431.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 11 Jan 2003 02:43:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 22:07, Werner Almesberger wrote:
> One general issue in this area is what we can do with time
> sources that aren't system-wide, e.g. NIC-local timers. The
> problem is to calibrate them and to synchronize them to
> wall-clock time. I think there are basically two possible
> approaches:

You run NTP between the host clock and the nic timer. Its
all you really need. In the i2it hardware the NIC clock 
implemented hardware slewing so it could do NTP stuff

