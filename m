Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288273AbSACS7B>; Thu, 3 Jan 2002 13:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288289AbSACS6v>; Thu, 3 Jan 2002 13:58:51 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:19216 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288273AbSACS6m>;
	Thu, 3 Jan 2002 13:58:42 -0500
Date: Thu, 3 Jan 2002 10:57:30 -0800
From: Greg KH <greg@kroah.com>
To: Roger Leblanc <r_leblanc@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
Message-ID: <20020103185730.GA11356@kroah.com>
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca> <20020103002827.GA4462@kroah.com> <3C33AF4F.7000703@videotron.ca> <20020103013231.GA4952@kroah.com> <3C33BD88.3010903@videotron.ca> <20020103030356.GA5313@kroah.com> <3C33CF71.4060202@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C33CF71.4060202@videotron.ca>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 06 Dec 2001 16:22:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 10:26:41PM -0500, Roger Leblanc wrote:
> Oops? I know about cores but I don't know about oopses. I'm only a C++, 
> hight level, OO developer. Sorry ;-). Can you explain please?

When the seg-fault happens, I am guessing that an oops message is sent
to the kernel log.  Look at 'dmesg'.  Run that oops through ksymoops.
See Documentation/oops-tracing.txt for more info on oopses and how to
get info from them.

thanks,

greg k-h
