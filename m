Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCVNXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCVNXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVCVNXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:23:45 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:42115 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261204AbVCVNXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:23:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.11-rc4: Alps touchpad too slow
Date: Tue, 22 Mar 2005 08:23:39 -0500
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Andy Isaacson <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <20050304221523.GA32685@hexapodia.org> <20050321222514.7f98e255.akpm@osdl.org> <20050322074146.GA3360@ucw.cz>
In-Reply-To: <20050322074146.GA3360@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503220823.39896.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 02:41, Vojtech Pavlik wrote:
> On Mon, Mar 21, 2005 at 10:25:14PM -0800, Andrew Morton wrote:
> 
> > > With cvsbk rev 423b66b6oJOGN68OhmSrBFxxLOtIEA (rsynced Monday, it claims
> > > to be "2.6.12-rc1"), the situation is much improved.  The AlpsPS/2
> > > driver recognizes the trackpad, tracking speed is back to normal, and
> > > tapping is turned on by default.  (Drat, now I need to figure out how to
> > > turn that off again.)
> 
> Setting "MaxTapTime" in XF86Config if you're using the Synaptics X
> driver, or mousedev.maxtaptime=0 if you are using /dev/input.mice, to 0
> should work.

Actually it is mousedev.tap_time=0

-- 
Dmitry
