Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264008AbRFSJ65>; Tue, 19 Jun 2001 05:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264015AbRFSJ6r>; Tue, 19 Jun 2001 05:58:47 -0400
Received: from c012-h025.c012.sfo.cp.net ([209.228.12.173]:20908 "HELO
	c012.sfo.cp.net") by vger.kernel.org with SMTP id <S264008AbRFSJ6i>;
	Tue, 19 Jun 2001 05:58:38 -0400
Date: 19 Jun 2001 02:58:34 -0700
Message-ID: <20010619095834.8228.cpmta@c012.sfo.cp.net>
X-Sent: 19 Jun 2001 09:58:34 GMT
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
To: schwab@suse.de
From: Ralph Jones <ralph.jones@altavista.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Web Mail 3.9.3.1
Subject: Re: pivot_root from non-interactive script
X-Sent-From: ralph.jones@altavista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  Yes it looks as if this might be the case.  Do you have any ideas how I might get around this?  Or do I have to use a different shell?

Ralph

On Mon, 18 June 2001, Andreas Schwab wrote:

> 
> Ralph Jones <ralph.jones@altavista.com> writes:
> 
> |> I have followed the instructions given in Documentation/initrd.txt with regard to pivot_root, but am unable to unmount the filesystem, when everything is called from a non-interactive script. 
> |> 
> |> ie. When I set a link from linuxrc to /bin/ash and then manually go through the commands in the shell script, I am able to unmount the old initrd filesystem.  However, when linuxrc is a shell script containing the same commands, I am unable to umount the old initrd fs.  I get instead: "Device or resource busy".
> 
> Perhaps the shell didn't close the filedescriptor on the script.
> 
> Andreas.
> 
> -- 
> Andreas Schwab                                  "And now for something
> SuSE Labs                                        completely different."
> Andreas.Schwab@suse.de
> SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
> Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5

Find the best deals on the web at AltaVista Shopping!
http://www.shopping.altavista.com
