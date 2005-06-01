Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVFAQW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVFAQW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVFAQWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 12:22:50 -0400
Received: from main.gmane.org ([80.91.229.2]:21731 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261454AbVFAQWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 12:22:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (=?utf-8?q?Dagfinn_Ilmari_Manns=C3=A5ker?=)
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Wed, 01 Jun 2005 18:20:32 +0200
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8jis0y3v73.fsf@ritchie.ping.uio.no>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org>
 <20050531190556.GK23621@csclub.uwaterloo.ca>
 <20050531195603.GB28168@bytesex> <429DDAA4.nail7BFB1SXEV@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ritchie.ping.uio.no
Mail-Copies-To: nobody
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:wJYBWOFG1LOpe55wVhLtdloAV7g=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

> Gerd Knorr <kraxel@suse.de> wrote:
>
>> > I don't know if the ide or scsi method is currently more sane, but it
>> > sure would be nice to have a consistent behaviour between the two.
>>
>> On my suse 9.3, out-of-the-box, I find this (implemented via
>> udev rules):
>>
>>    # find /dev/cd /dev/disk -type l -print | sort
>>    /dev/cd/by-id/HL-DT-ST_DVDRAM_GSA-4040B_K213BDG5213
>>    /dev/cd/by-id/LG_CD-RW_CED-8080B_2000_07_27e
>>    /dev/cd/by-path/pci-0000:00:04.1-ide-1:0
>>    /dev/cd/by-path/pci-0000:00:04.1-ide-1:1
>>    /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751
>>    /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751p1
>
> Nice, but will be the Linux /dev/ fashion next year?
>
> From my experiences it makes no sense to implement support
> for things like this before waiting long enough to know 
> whether this is something that will become ordinary.

You don't need to implement any special support for this. Just stop
whining about open by device node and let the user specify whichever
path to the same device she prefers.

-- 
ilmari

