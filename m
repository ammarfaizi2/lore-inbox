Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTIGV7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTIGV7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:59:13 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17857 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261686AbTIGV7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:59:07 -0400
Date: Sun, 7 Sep 2003 22:58:04 +0100
From: Dave Jones <davej@redhat.com>
To: cheapisp@sensewave.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: hi-res fb console with 2.6.0-testX ?
Message-ID: <20030907215803.GB28927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, cheapisp@sensewave.com,
	linux-kernel@vger.kernel.org
References: <10539.80.202.106.246.1062964311.squirrel@to.server.sensewave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10539.80.202.106.246.1062964311.squirrel@to.server.sensewave.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 09:51:51PM +0200, cheapisp@sensewave.com wrote:
 > The kernel command lines which work with vesafb and matroxfb in 2.4 do not 
 > work for me in 2.6.0-testX.                                                
 >                                    
 > kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 video=matrox:vesa:0x11A       
 > kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 vga=794                       
 >                                    
 > both result in something resembling a Vesa 101 mode under 2.6.0-test4-mm3. 
 >                                    
 > (640x480, 60 Hz)                                                           
 >                                    
 > I'd expect 1280x1024 in 60 Hz, which is what I get with a 2.4 kernel.      

vga= seems to have changed semantics. (Which is a polite way of saying
"has regressed" IMO), this has been reported several times before, but
it doesn't seem to be too high on peoples 'must fix' list.

 > Doing fbset "vesa11A" causes the monitor to lose the sync.                 

last I looked, fbset needed updates for the changes in 2.6

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
