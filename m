Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282963AbSAASjc>; Tue, 1 Jan 2002 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbSAASjP>; Tue, 1 Jan 2002 13:39:15 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:47889 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S282963AbSAASi7>; Tue, 1 Jan 2002 13:38:59 -0500
Date: Tue, 1 Jan 2002 19:38:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Findlay <david_j_findlay@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Joystick driver
Message-ID: <20020101193854.B30616@suse.cz>
In-Reply-To: <200201010307.g0137icS006022@ADSL-Server.davsoft.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201010307.g0137icS006022@ADSL-Server.davsoft.com.au>; from david_j_findlay@yahoo.com.au on Tue, Jan 01, 2002 at 01:07:44PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 01:07:44PM +1000, David Findlay wrote:

> I think i've discovered a bug in the analog joystick driver. I have a 
> multifunction analog joystick which defaults to a mode where the 4 standard 
> joystick buttons are linked to keystrokes. In this mode the joystick has no 
> standard joystick buttons, and the kernel doesn't detect it when booting. If 
> i turn off this switch before booting up the kernel detects the joystick as a 
> 4 button 2 axis joystick correctly. Could someone please change the analog 
> joystick driver so it doesn't try to detect buttons, and will just accept 
> input from any button when it is pressed, even if the button wasn't 
> previously detected? Or is there a better solution? Thanks,

Sorry, it doesn't try to detect buttons.

-- 
Vojtech Pavlik
SuSE Labs
