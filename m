Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282728AbRLOPbc>; Sat, 15 Dec 2001 10:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282736AbRLOPbX>; Sat, 15 Dec 2001 10:31:23 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:15879 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S282728AbRLOPbK>; Sat, 15 Dec 2001 10:31:10 -0500
Date: Sat, 15 Dec 2001 16:31:05 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Edward Killips <etkillips@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netfilter Oops more info
Message-ID: <20011215153104.GB12155@arthur.ubicom.tudelft.nl>
In-Reply-To: <F62gvjDrzzyCx91MjVM0000410c@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F62gvjDrzzyCx91MjVM0000410c@hotmail.com>
User-Agent: Mutt/1.3.24i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 10:08:33AM -0500, Edward Killips wrote:
> I get a netfilter Oops like the one below unless I comment out the 
> follwoing rule.
> iptables -t mangle -A PREROUTING -m multiport -p tcp --sport 80,21,23 -j 
> TOS --set-tos 16
> 
> ksymoops 2.4.3 on i586 2.4.17-rc1.  Options used
>     -V (default)
>     -k /proc/ksyms (default)
>     -l /proc/modules (default)
>     -o /lib/modules/2.4.17-rc1/ (default)
>     -m /boot/System.map (specified)
> 
> c0216e84
> *pde = 00000000
> Oops:  0000
> CPU: 0
> EIP: 0010:[c0216e84>] Not tainted

Consider upgrading modutils so it's immediately clear that you are
using binary-only modules.

> Trace; d88919e8 <[lt_modem]UART_CopyDteTxData+44/dc>
                    ^^^^^^^^
Binary-only module, only the supplier of the module (Lucent, IIRC) can
help you debug the Oops.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
