Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSIEQYQ>; Thu, 5 Sep 2002 12:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSIEQYQ>; Thu, 5 Sep 2002 12:24:16 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:14097 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317872AbSIEQYO>;
	Thu, 5 Sep 2002 12:24:14 -0400
Date: Thu, 5 Sep 2002 09:26:44 -0700
From: Greg KH <greg@kroah.com>
To: Peter <cogweb@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 build problem
Message-ID: <20020905162644.GB12763@kroah.com>
References: <20020905065825.GA10140@kroah.com> <Pine.LNX.4.44.0209050025460.14137-100000@greenie.frogspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209050025460.14137-100000@greenie.frogspace.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<offtopic, your site keeps refusing my direct email due to a procmail
configuration bug on your site>

On Thu, Sep 05, 2002 at 01:00:33AM -0700, Peter wrote:
> 
> In that case, let's add this to the help screens for the three device
> types (CONFIG_INPUT_KEYBDEV, CONFIG_INPUT_MOUSEDEV, CONFIG_INPUT_JOYDEV), 
> after the current text:
> 
> For the drivers to link correctly, you must make the same selection (Y or
> M) here as for the USB Human Interface Device (full HID) support.
> 
> Under CONFIG_USB_HID, likewise add after the current text:
> 
> For the drivers to link correctly, you must make the same selection (Y or
> M) here as for Input core support.

That sounds reasonable.

> That said, I suggest that Input core support menu be moved into the USB
> support menu, where these dependency relations can be automated and made 
> visible to the user. 

No, the Input core is separate from the USB code, it does not belong in
that menu.

> I apologize for not submitting a patch -- it's a skill I lack.

Take a look at Documentation/SubmittingPatches, it should help you learn
those skills :)

thanks,

greg k-h
